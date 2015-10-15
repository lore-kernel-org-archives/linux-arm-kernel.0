From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 14 Oct 2015 17:14:04 -0700
Subject: [PATCH v3 0/4] input: gpio_keys_polled: Add support for abs/rel
 axis
In-Reply-To: <1442928240-2452-1-git-send-email-hdegoede@redhat.com>
References: <1442928240-2452-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20151015001404.GB3673@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 03:23:56PM +0200, Hans de Goede wrote:
> Hi Dmitry,
> 
> This patch-series really is 2 related series:
> 
> Patch 1 + 2:
> 
> Support for abs/rel axis in gpio_keys_polled, the dt-bindings patch is
> updated, the actual implementation is the same as the v2 version.
> 
> Patch 3 + 4:
> 
> Add a single header with key / btn / axis defines to be shared by input.h
> and the dt-bindings headers, as requested by you. The first patch introduces
> a new header for this, the second patch makes dt-bindings/input/input.h
> use this new header. The second patch has been Acked by the devicetree
> maintainer, and since it depends on the first one I believe that it is
> best if this patch gets merged via your tree too.

Applied the lot, thank you.

-- 
Dmitry
