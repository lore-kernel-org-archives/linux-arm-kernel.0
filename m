From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 30 Nov 2016 17:05:22 +0100
Subject: [PATCH v2 1/4] drm: Add support for Amlogic Meson Graphic
 Controller
In-Reply-To: <3713265.h5djxipShb@avalon>
References: <1480520625-13269-1-git-send-email-narmstrong@baylibre.com>
 <1480520625-13269-2-git-send-email-narmstrong@baylibre.com>
 <3713265.h5djxipShb@avalon>
Message-ID: <dd2076e9-6ce7-96d6-2584-3c2642f6b5ac@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2016 05:03 PM, Laurent Pinchart wrote:
> Hi Neil,
> 
> Thank you for the patch.
> 
> I'm afraid I don't have time for a complete review, but could you please get 
> rid of the of_machine_is_compatible() calls and match on the VPU compatible 
> string instead ?

Oops, I knew I forgot to change this one...

I will get rid of these for the v3.

Thanks,
Neil
