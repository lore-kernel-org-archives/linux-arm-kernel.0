From: drake@endlessm.com (Daniel Drake)
Date: Thu, 26 Jun 2014 10:24:23 +0100
Subject: [PATCH v2 4/6] ARM: SAMSUNG: Restore Samsung PM Debug
 functionality
In-Reply-To: <1403696634-12779-1-git-send-email-t.figa@samsung.com>
References: <1403618235-19353-5-git-send-email-t.figa@samsung.com>
 <1403696634-12779-1-git-send-email-t.figa@samsung.com>
Message-ID: <CAD8Lp46X_urw=ayVZNL8Af9pMUD4st7tAtuMvkrg+A6YsxpiMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 12:43 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Due to recently merged patches and previous merge conflicts, the Samsung
> PM Debug functionality no longer can be enabled. This patch fixes
> incorrect dependency of SAMSUNG_PM_DEBUG on an integer symbol and adds
> missing header inclusion.

I replaced the original patch with this updated version and can
confirm that the option now appears in the menu again, and compile
succeeds when set to yes.

Thanks
Daniel
