From: joe@perches.com (Joe Perches)
Date: Thu, 20 Mar 2014 05:13:50 -0700
Subject: [PATCH 1/5] mtd: st_spi_fsm: Remove useless consts from
 function arguments
In-Reply-To: <20140320120307.GA9240@lee--X1>
References: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
 <1395313907-25318-2-git-send-email-lee.jones@linaro.org>
 <1395314713.7776.17.camel@joe-AO722> <20140320114123.GE21349@lee--X1>
 <1395316090.7776.24.camel@joe-AO722>
 <20140320115412.GU31517@norris-Latitude-E6410>
 <20140320120307.GA9240@lee--X1>
Message-ID: <1395317630.7776.29.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-03-20 at 12:03 +0000, Lee Jones wrote:
> > Good catch. That wasn't my intention.
> > > Why?
> An oversight.

That's still not an explanation.

Why, unless cast away by the code itself, is
const removal a good thing?

It does serve as an indication to a reader what
the code does with the argument.

About the only reason I can think of arguing in
favor of removal is inconsistent application of
const within the module.
