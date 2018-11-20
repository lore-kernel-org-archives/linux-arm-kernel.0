From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Nov 2018 11:02:03 +0100
Subject: [PATCH v2 0/2] add SAMA5D2 PIOBU GPIO driver
In-Reply-To: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
References: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
Message-ID: <CACRpkdZj4g9Ht-4sHjFMCmaeZnwmM3AcMaN2rQ65O1Ykgp2eWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrei,

On Tue, Nov 20, 2018 at 9:08 AM <Andrei.Stefanescu@microchip.com> wrote:

> On SAMA5D2 SoC the PIOBU pins do not lose their
> voltage during Backup/Self-refresh mode. This can
> be useful, for example, when the voltage must remain
> positive for a peripheral during Backup/Self-refresh
> mode (suspend-to ram is the Linux equivalent state).
>
> v2:

This version looks good to me, I'm just waiting for a DT
binding review.

Yours,
Linus Walleij
