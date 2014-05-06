From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 06 May 2014 10:04:37 -0700
Subject: [PATCH v10 00/15] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
In-Reply-To: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140506170437.5739.402@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Hans de Goede (2014-05-02 08:57:14)
> The first 2 patches are depenencies which should go in through the clk tree,
> Mike can you pick these 2 up please ?  :

Taken into clk-next.

> 
> "clk: sunxi: factors: automatic reparenting support"
> Is uncontroversial and has been favorably reviewed by various people.
> 
> "clk: sunxi: Implement MMC phase control"
> Is somewhat more controversial as there has been lots of discussion about
> adding a generic phase control method to the clk framework. The problem is
> that there has been a lot of talk about such a generic phase control method
> but not a single patch. Therefor I would like to move forwards with using
> a platform specific method for now. I hereby promise that once we've a generic
> method I'll write patches to convert the sunxi code to that method.

Thanks for the promise. I will hold you to it once the set_phase api is
sorted ;-)

Also thanks for the clear and concise cover letter. It is very helpful
when going through the tenth iteration of a series.

Regards,
Mike
