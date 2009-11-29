From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 29 Nov 2009 10:29:44 +0800
Subject: [PATCH 2/3 v2] pcm990-baseboard: don't use pxa_camera init()
	callback
In-Reply-To: <1259353896-16892-1-git-send-email-ospite@studenti.unina.it>
References: <Pine.LNX.4.64.0911181110180.5702@axis700.grange>
	<1259353896-16892-1-git-send-email-ospite@studenti.unina.it>
Message-ID: <f17812d70911281829h6f653c72q21ded878d1181bf7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2009 at 4:31 AM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> pxa_camera init() is ambiguous, it's better to configure PXA CIF pins
> statically in machine init function.
>
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

I'll grab this and get it exposed to next -rc phase.
