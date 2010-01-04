From: maz@misterjones.org (Marc Zyngier)
Date: Mon, 4 Jan 2010 22:56:20 +0100
Subject: [ARM] pxa: use chip->ack() instead of accessing GEDR directly
In-Reply-To: <f17812d71001031814p52e99b6bhbcafd35c71439c47@mail.gmail.com>
References: <f17812d71001031814p52e99b6bhbcafd35c71439c47@mail.gmail.com>
Message-ID: <20100104225620.6f5db8a7@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Jan 2010 10:14:51 +0800
Eric Miao <eric.y.miao@gmail.com> wrote:

>     [ARM] pxa: use chip->ack() instead of accessing GEDR directly
> 
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

For the Viper part:

Acked-by: Marc Zyngier <maz@misterjones.org>

	M.
-- 
I'm the slime oozin' out from your TV set...
