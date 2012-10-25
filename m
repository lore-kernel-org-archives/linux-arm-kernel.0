From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Oct 2012 08:56:54 +0200
Subject: [PATCH 2/3] pinctrl: mvebu: remove useless include
In-Reply-To: <1351114738-26793-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351114738-26793-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351114738-26793-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdZVoP2EROpMf22vWPbKueHZpsdA9N_vFFb_Xoz3VnNo7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 11:38 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> Including the core.h header for the pinctrl subsystem is not
> necessary, and it is actually causing problems when moving the
> pinctrl-mvebu drivers into a separate subdirectory.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied, thanks!

Yours,
Linus Walleij
