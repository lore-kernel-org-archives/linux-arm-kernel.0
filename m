From: mark.roszko@gmail.com (Mark Roszko)
Date: Mon, 4 Aug 2014 12:29:56 -0400
Subject: [PATCH] i2c:at91: add bound checking on smbus block length bytes
In-Reply-To: <1404457391-22330-1-git-send-email-mark.roszko@gmail.com>
References: <1404457391-22330-1-git-send-email-mark.roszko@gmail.com>
Message-ID: <CAJjB1qJvvaO3PtN5dMAAAeABS5YMmRc1VRwKo6G_ZuDuo6L15g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

Have you had a chance to look? This causes kernel panic in at91 systems in
noisy environments and/or unreliable smbus slaves if left unfixed.

Regards,
Mark
