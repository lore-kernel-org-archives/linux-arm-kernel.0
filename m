From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 12 Sep 2014 09:22:06 +0200
Subject: [PATCH v3 00/12] clk: sunxi: Improve MMC clocks support
In-Reply-To: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54129F1E.30207@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/11/2014 10:18 PM, Maxime Ripard wrote:
> Hi everyone,
> 
> Here is an attempt at improving the MMC clock support in the Allwinner
> SoCs.
> 
> Until now, the MMC clocks were having a custom phase function that was
> directly setting an obscure value in the right register, because we
> were not really having any idea of what these values were.
> 
> Now that we have more informations, we can introduce a common function
> call to get and set the phase of a particular clock, and use this in
> both our provider and our client.
> 
> Thanks,
> Maxime

I've not done a full review this time around (-ENOTIME), but I've taken
a look at the changed bits, and those look good to me.

Regards,

Hans
