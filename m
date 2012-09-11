From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 11 Sep 2012 15:15:40 +0100
Subject: [PATCH 06/12] tty/serial/kgdboc: Add and wire up clear_irqs
 callback
In-Reply-To: <1347356106-25368-6-git-send-email-anton.vorontsov@linaro.org>
References: <20120911093042.GA12471@lizard>
 <1347356106-25368-6-git-send-email-anton.vorontsov@linaro.org>
Message-ID: <20120911151540.362001c6@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Sep 2012 02:35:00 -0700
Anton Vorontsov <anton.vorontsov@linaro.org> wrote:

> This patch implements a new callback: clear_irqs. It is used for the


This bit I still really don't like. I would like to know what the generic
IRQ folks thing about it and if Thomas Gleixner has any brilliant ideas
here. I don't think its a show stopper it would just be nice if there was
a better solution first.

Alan
