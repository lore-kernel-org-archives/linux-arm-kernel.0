From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 8 Nov 2009 14:54:59 +0800
Subject: [PATCH 1/2] Colibri/PXA320: Fix AC97 ifdefs and include
In-Reply-To: <200911080305.11772.marek.vasut@gmail.com>
References: <200911080305.11772.marek.vasut@gmail.com>
Message-ID: <f17812d70911072254y2b174d01ue0381f408cd414be@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 8, 2009 at 10:05 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> From 39b8a11d86905c0ed50932aa4f57dce8c46e9dd9 Mon Sep 17 00:00:00 2001
> From: Marek Vasut <marek.vasut@gmail.com>
> Date: Sun, 8 Nov 2009 02:24:05 +0100
> Subject: [PATCH 1/2] Colibri/PXA320: Fix AC97 ifdefs and include
>
> The AC97 part wasn't initialized on Colibri/PXA320 because the macros were
> wrong. Also, the code didn't compile because of a header file not being
> included.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Fix looks obvious to me. Applied to 'fix', and Daniel, I assume you
are OK with this.
