From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 09 Feb 2013 13:28:03 +0000
Subject: [PATCH 7/9] gpiolib: let gpio_chip reference its descriptors
In-Reply-To: <CACRpkdZ3L15vbfBGC-SmmGKnt8N_GZGKP92su3aZWQZdPPVR2Q@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-9-git-send-email-acourbot@nvidia.com>
 <CACRpkdZ3L15vbfBGC-SmmGKnt8N_GZGKP92su3aZWQZdPPVR2Q@mail.gmail.com>
Message-ID: <20130209132803.AC8323E30EC@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Feb 2013 19:00:09 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> 
> > Add a pointer to the gpio_chip structure that references the array of
> > GPIO descriptors belonging to the chip, and update gpiolib code to use
> > this pointer instead of the global gpio_desc[] array. This is another
> > step towards the removal of the gpio_desc[] global array.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.orh>

Applied, thanks.

g.
