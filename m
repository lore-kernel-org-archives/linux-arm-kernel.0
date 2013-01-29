From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 29 Jan 2013 23:54:13 +0100
Subject: [PATCH 1/3] pinctrl: sunxi: Add of_xlate function
In-Reply-To: <CACRpkdZi0zCNf6LDd9UAcd57kFqqWyteVqxL8WfDrFfrt9_5sQ@mail.gmail.com>
References: <1359313332-12305-1-git-send-email-maxime.ripard@free-electrons.com>
 <1359313332-12305-2-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdZi0zCNf6LDd9UAcd57kFqqWyteVqxL8WfDrFfrt9_5sQ@mail.gmail.com>
Message-ID: <51085315.2000302@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 29/01/2013 23:41, Linus Walleij a ?crit :
> On Sun, Jan 27, 2013 at 8:02 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
>> Since the pin controller of sunxi chips is represented as a single bank
>> in the driver.
>> Since this is neither convenient nor represented that way in the
>> datasheets, define a custom of_xlate function with the layout <bank pin
>> flag>
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> This does not apply and I only have 1/3 it seems?
> 
> Sorry, help me understand which order these patches go in...

My bad, I forgot to mention the order of the patchsets, and to cc you
for the all series... Sorry about that.

This patch should come after the patch series that adds the support for
the A10 SoCs in the pinctrl driver.

Do you want me to resend this serie and cc you?

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
