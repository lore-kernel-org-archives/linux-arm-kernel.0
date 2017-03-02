From: keescook@chromium.org (Kees Cook)
Date: Thu, 2 Mar 2017 00:38:30 -0800
Subject: [PATCH] ARM: dump: Add domain to output
In-Reply-To: <20170302075554.GA33308@beast>
References: <20170302075554.GA33308@beast>
Message-ID: <CAGXu5j+nO5oZuWLwPpv3mQbv-0Msu7KWEddd-wVEt3sBzZdHLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 1, 2017 at 11:55 PM, Kees Cook <keescook@chromium.org> wrote:
> This adds the memory domain (on non-LPAE) to the PMD and PTE dumps. This
> isn't in the regular PMD bits because I couldn't find a clean way to
> fall back to retain some of the PMD bits when reporting PTE. So this is
> special-cased currently.

Ugh, please ignore this. Further testing shows this doesn't work
right... I'll keep poking at it.

-Kees

-- 
Kees Cook
Pixel Security
