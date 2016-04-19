From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 19 Apr 2016 18:16:14 -0400
Subject: [PATCH v2] Documentation: devicetree: Clean up gpio-keys example
In-Reply-To: <20160419221349.GA25916@rob-hp-laptop>
References: <1458129209-15449-1-git-send-email-afaerber@suse.de>
 <20160419221349.GA25916@rob-hp-laptop>
Message-ID: <CABxcv=nYoVss97WLgAxFfiwZZtStRNjEGZ0z-aYdb0JWiJaywQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rob,

On Tue, Apr 19, 2016 at 6:13 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Mar 16, 2016 at 12:53:29PM +0100, Andreas F?rber wrote:
>> Drop #address-cells and #size-cells, which are not required by the
>> gpio-keys binding documentation, as button sub-nodes are not devices.
>>
>> Rename sub-nodes to avoid new dtc unit address warnings when copied.
>>
>> While at it, adopt the dashes convention for the node name.
>>
>> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
>> Cc: Julien Chauveau <chauveau.julien@gmail.com>
>> Cc: Javier Martinez Canillas <javier@dowhile0.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>
> Applied, thanks.
>

Dmitry already applied this patch in the input tree.

> Rob
>

Best regards,
Javier
