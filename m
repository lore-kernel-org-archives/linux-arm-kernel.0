From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 09 Mar 2015 20:53:58 +0100
Subject: [PATCH v5 3/8] pinctrl: cygnus: add initial IOMUX driver support
In-Reply-To: <54FDF72E.2010806@broadcom.com>
References: <1425515756-321-1-git-send-email-rjui@broadcom.com>
 <1425515756-321-4-git-send-email-rjui@broadcom.com>
 <1425542612.24292.180.camel@x220>
 <CACRpkdYTDSSSd5oDNXmcav-2ycbki0=K+0Cm6dLSBHUv6UXF9g@mail.gmail.com>
 <1425926456.2317.13.camel@tiscali.nl> <54FDEDBA.1070404@broadcom.com>
 <1425929442.2317.39.camel@tiscali.nl> <54FDF72E.2010806@broadcom.com>
Message-ID: <1425930838.2317.46.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ray Jui schreef op ma 09-03-2015 om 12:40 [-0700]:
> I don't see this as an "issue" to be quite honest.

(Off topic: is issue a, well, strong word? To my (non-English) mind it's
rather neutral, carrying by itself less urgency than, say, problem. If
I'm wrong I might have confused quite a few people by using it quite
often. And that would be a real issue!)

> By saying that, I at
> least agree with you that these are not information that's mandatory to
> be in the driver given what we already have. MODULE_LICENSE is covered
> by license header. MODULE_DESCRIPTION is covered by descriptions in
> Kconfig. MODULE_AUTHOR is much less important than what's in the
> MAINTAINERS list.
> 
> Since I have to submit a new patch series to address the "ngpios" issue
> that Linus mentioned in the other email, I don't mind removing all these
> MODULE_* macros in the driver all together.

I see.

Thanks,


Paul Bolle
