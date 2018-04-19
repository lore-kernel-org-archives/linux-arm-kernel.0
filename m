From: swboyd@chromium.org (Stephen Boyd)
Date: Wed, 18 Apr 2018 23:04:31 -0700
Subject: [PATCH v2 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com>
 <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
Message-ID: <152411787180.46528.5441480997805485928@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting David Collins (2018-04-18 16:30:26)
> On 04/17/2018 01:02 PM, Doug Anderson wrote:
> > On Fri, Apr 13, 2018 at 7:50 PM, David Collins <collinsd@codeaurora.org> wrote:
> >> +#define RPMH_REGULATOR_DISABLE                 0x0
> >> +#define RPMH_REGULATOR_ENABLE                  0x1
> > 
> > In the last version Stephen said he didn't like the above two #defines
> > and you said you'd remove them, yet they are still here.  Explanation?
> 
> I thought that he was referring to the comments above the constants since
> his review comment was immediately following the second of two comments as
> opposed to these constants.  I'll let him follow-up on this point if
> necessary.
> 

I think I was talking about the comments. The defines don't look super
useful either though.
