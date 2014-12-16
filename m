From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 16 Dec 2014 15:12:14 +0100
Subject: [PATCH 0/4] mmc: sunxi: General fixup (v2)
In-Reply-To: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
References: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
Message-ID: <54903DBE.1090100@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16-12-14 15:10, David Lanzend?rfer wrote:
> Hello
> This patchset was inspired questions from ?? of Allwinner and incorporates as
> well suggestions from Hans related to spin locks.
> For example have not all attributes of the shared host object been protected
> by the spin lock, this has been changed.
> Also some register names and reset behavior have been fixed now.
> And a minor cleanup happened at the clock frequecy setting, since there has
> been a piece of left over code which has been there because it was in the Android
> driver and we just adapted it because we didn't have proper documentation about
> the timing of the module.
>
> Looking forward to your feedback
> Cheers David

Thanks.

Series looks good and is:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
