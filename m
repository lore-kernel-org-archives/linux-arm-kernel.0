From: a.zummo@towertech.it (Alessandro Zummo)
Date: Fri, 20 Dec 2013 12:06:06 +0100
Subject: [PATCH v2 2/2] ARM: sun4i/sun7i: RTC driver
In-Reply-To: <20131022152313.GU3041@lukather>
References: <1381948227-6290-1-git-send-email-carlo.caione@gmail.com>
 <1381948227-6290-2-git-send-email-carlo.caione@gmail.com>
 <20131022152313.GU3041@lukather>
Message-ID: <20131220120606.78fcd8c5@linux.lan.towertech.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Oct 2013 16:23:13 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > +	platform_set_drvdata(pdev, chip);
> > +	chip->dev = &pdev->dev;

 is chip->dev ever used?

 Acked-by: Alessandro Zummo <a.zummo@towertech.it>

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
