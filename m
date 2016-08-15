From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 15 Aug 2016 09:34:02 +0200
Subject: [PATCH v9 0/2] [media] atmel-isc: add driver for Atmel ISC
In-Reply-To: <1470899202-13933-1-git-send-email-songjun.wu@microchip.com>
References: <1470899202-13933-1-git-send-email-songjun.wu@microchip.com>
Message-ID: <676111f8-e179-b2cc-4792-cd4304995e31@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2016 09:06 AM, Songjun Wu wrote:
> The Image Sensor Controller driver includes two parts.
> 1) Driver code to implement the ISC function.
> 2) Device tree binding documentation, it describes how
>    to add the ISC in device tree.

So close...

Running checkpatch gives me:

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#133:
new file mode 100644

Can you make a patch adding an entry to MAINTAINERS? No need to repost the other
two.

Regards,

	Hans
