From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Sep 2014 10:28:38 +0100
Subject: [PATCH V3 0/6] RCU get_user_pages_fast and __get_user_pages_fast
In-Reply-To: <20140919182808.GA22622@linaro.org>
References: <1409237107-24228-1-git-send-email-steve.capper@linaro.org>
 <20140828152320.GN22580@arm.com>
 <CAPvkgC0YVhPEBqbWSDnGyZBUn3+8Kv7-yx1-_n0Jx+giKzOqmw@mail.gmail.com>
 <20140908090626.GA14634@linaro.org>
 <20140919182808.GA22622@linaro.org>
Message-ID: <20140922092838.GC25809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 07:28:09PM +0100, Steve Capper wrote:
> Apologies for being a pest, but we're really keen to get this into 3.18,
> as it fixes a THP problem with arm/arm64.
> 
> I need mm folk to either ack or flame the first patch in the series in
> order to proceed. (All the patches in the series have been
> acked/reviewed, but not by any mm folk.):
>  [PATCH V3 1/6] mm: Introduce a general RCU get_user_pages_fast.
> 
> If it puts people's minds at rest regarding the testing...
> On top of the ltp tests, and futex tests, we also ran these patches on
> the arm64 Debian buildd's. With THP set to always, just under 8000
> Debian packages have been built (and unit tested) without any kernel
> issues for arm64.

Yes, please. It would be great if somebody can take these into an -mm tree
and/or provide an ack so that we can queue them via the arm64 tree instead.

Will
