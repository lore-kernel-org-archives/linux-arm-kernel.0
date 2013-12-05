From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 05 Dec 2013 16:11:15 +0100
Subject: [PATCH] pinctrl: samsung: Allow pin value to be initialized using
 pinfunc.
In-Reply-To: <20131205150747.GW29268@sirena.org.uk>
References: <1384881351-10782-1-git-send-email-t.figa@samsung.com>
 <CACRpkdYrPd9tnO48bA_5n+-k=KEDyhY7czkCNhTZfpgF3ar+LQ@mail.gmail.com>
 <20131205150747.GW29268@sirena.org.uk>
Message-ID: <1502243.eRBlCfUhTO@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 of December 2013 15:07:47 Mark Brown wrote:
> On Tue, Dec 03, 2013 at 10:29:42AM +0100, Linus Walleij wrote:
> 
> > So a suggested patch to support weak hogs would be interesting
> > to look at. Can you provide details on how you think this would
> > work?
> 
> Or should we be going and applying the default state to all devices on
> init without worrying about a driver appearing?

If a device isn't used, then it's often better to configure the pins for
a different function, such as GPIO, to minimize leakage current.

Best regards,
Tomasz
