From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 13 Aug 2015 15:13:16 -0700
Subject: [PATCH v5] mtd: spi-nor: add driver for NXP SPI Flash Interface
 (SPIFI)
In-Reply-To: <CAGhQ9Vzs2h3mw2qnYvy83RAvrX8uPZGGzNASr1csk_LhLnHB8g@mail.gmail.com>
References: <1439486380-17720-1-git-send-email-manabian@gmail.com>
 <20150813214739.GH60523@google.com>
 <CAGhQ9Vzs2h3mw2qnYvy83RAvrX8uPZGGzNASr1csk_LhLnHB8g@mail.gmail.com>
Message-ID: <20150813221316.GI60523@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 12:10:59AM +0200, Joachim Eastwood wrote:
> On 13 August 2015 at 23:47, Brian Norris <computersforpeace@gmail.com> wrote:
> > BTW, is this driver worth a MAINTAINERS entry? It's nice to always have
> > someone on CC that has the hardware. The git history should probably
> > pick you up anyway when running get_maintainers.pl, so it may not be
> > absolutely necessary.
> 
> Sure. I can add it under the main lpc18xx platform entry in
> MAINTAINERS. I'll queue up a patch for arm-soc.

Sounds good.
