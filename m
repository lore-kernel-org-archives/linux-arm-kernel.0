From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Apr 2017 11:56:44 +0200
Subject: [PATCH v3 7/7] ARM: dma-mapping: Remove traces of NOMMU code
In-Reply-To: <1489137839-549-8-git-send-email-vladimir.murzin@arm.com>
References: <1489137839-549-1-git-send-email-vladimir.murzin@arm.com>
 <1489137839-549-8-git-send-email-vladimir.murzin@arm.com>
Message-ID: <CAK8P3a3ogS9RyxqOvxN1EQi2BWo-bpMVHasgY=eh48RMhmzVWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 10:23 AM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
> DMA operations for NOMMU case have been just factored out into
> separate compilation unit, so don't keep dead code.
>
> Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Tested-by: Andras Szemzo <sza@esh.hu>
> Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

The patch is "obviously correct" after the previous changes,

Acked-by: Arnd Bergmann <arnd@arndb.de>
