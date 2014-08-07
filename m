From: sam@ravnborg.org (Sam Ravnborg)
Date: Thu, 7 Aug 2014 21:42:59 +0200
Subject: [PATCH 00/10 v3] Coresight framework and drivers
In-Reply-To: <1407435706-19441-1-git-send-email-mathieu.poirier@linaro.org>
References: <1407435706-19441-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20140807194259.GB2351@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu.

Maybe I just missed it, but ...
> 
> As part of this patchset you will find:
> 
> . The return of non-configurable replicators.  Since they don't
>   show up on the AMBA bus we need to use the platform device model.
> . It is now possible to configure and use multiple sinks simultaneously.
> . The coresigh config entries have been moved to arch/arm/Kconfig.debug.
> . Documentation for bindings has been removed from this submission and 
>   will be sent separately.
> . "of_coresight.h" has been folded into "coresight.h".
> . Miscellaneous style problems have been addressed.

this introduction give me no clue what coresight is about.

I most likely do not need to know since this look to be arm specific,
but this kind of info is always nice to have included as a service
to the poor people that is not on-top of everything.

	Sam
