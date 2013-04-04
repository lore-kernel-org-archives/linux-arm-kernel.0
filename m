From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Wed, 03 Apr 2013 21:02:31 -0300
Subject: [PATCH V2 4/7] kbuild: always run gcc -E on *.dts,
 remove cmd_dtc_cpp
In-Reply-To: <1365032098-22825-4-git-send-email-swarren@wwwdotorg.org>
References: <1365032098-22825-1-git-send-email-swarren@wwwdotorg.org>
 <1365032098-22825-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <515CC317.2000703@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

El 03/04/13 20:34, Stephen Warren escribi?:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Replace cmd_dtc with cmd_dtc_cpp, and delete the latter.
> 
> Previously, a special file extension (.dtsp) was required to trigger
> the C pre-processor to run on device tree files. This was ugly. Now that
> previous changes have enhanced cmd_dtc_cpp to collect dependency
> information from both gcc -E and dtc, we can transparently run the pre-
> processor on all device tree files, irrespective of whether they
> 

I think a line got dropped on the commit description by mistake.

Regards,

Emilio
