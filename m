From: drake@endlessm.com (Daniel Drake)
Date: Wed, 25 Jun 2014 11:09:11 +0100
Subject: [PATCH 4/6] ARM: SAMSUNG: Restore Samsung PM Debug functionality
In-Reply-To: <1403618235-19353-5-git-send-email-t.figa@samsung.com>
References: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
 <1403618235-19353-5-git-send-email-t.figa@samsung.com>
Message-ID: <CAD8Lp46GpaGzq+2bkyujRtSVYJt7PWWT47NvjifoxzJk7aKs6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Tue, Jun 24, 2014 at 2:57 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Due to recently merged patches and previous merge conflicts, the Samsung
> PM Debug functionality no longer can be enabled. This patch fixes
> incorrect dependency of SAMSUNG_PM_DEBUG on an integer symbol and adds
> missing header inclusion.

Testing against 3.16-rc2, this doesn't quite work for me.
SAMSUNG_PM_DEBUG still doesn't appear in menuconfig.

HAVE_SAMSUNG_PM_DEBUG is 'n'. Looks like the select from
DEBUG_S3C_UART is not working, but I'm not sure why.

Daniel
