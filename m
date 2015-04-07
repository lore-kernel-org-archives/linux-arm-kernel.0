From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 7 Apr 2015 19:49:02 +0800
Subject: [PATCH] pinctrl: at91: convert __raw to endian agnostic IO
In-Reply-To: <CACRpkdY26txvV92SePv02EdX6TOcTBn9uWPX08gC2oAi7XGs0A@mail.gmail.com>
References: <1427372329-26005-1-git-send-email-ben.dooks@codethink.co.uk>
 <CACRpkdY26txvV92SePv02EdX6TOcTBn9uWPX08gC2oAi7XGs0A@mail.gmail.com>
Message-ID: <A0B30D6A-11E5-4D5D-AA0F-9AC807431459@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Apr 7, 2015, at 5:06 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> On Thu, Mar 26, 2015 at 1:18 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> 
>> Use endian agnostic _relaxed IO accessors instead of the __raw ones.
>> 
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Uncontroversial. Applied with Nicolas' ACK.
I ack the whole series so yes

Best Regards,
J.
