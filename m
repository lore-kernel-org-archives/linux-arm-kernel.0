From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Jun 2017 09:36:34 +0200
Subject: [PATCH] clk: sunxi-ng: Move all clock types to a library
In-Reply-To: <CAGb2v66QvLdojDe4+uG9Opa7fApA-GH9pW4v0En5j6QSPf1yZw@mail.gmail.com>
References: <20170602223006.1653-1-sboyd@codeaurora.org>
 <201706031243.qNvuUbQX%fengguang.wu@intel.com>
 <20170605144546.b6oh5sygrza22hbe@flea.lan>
 <CAK8P3a1Qvt4nvM5HeK-n87tsi2D5GBOmZo0rZv_Lp==CC=34Uw@mail.gmail.com>
 <CAGb2v66QvLdojDe4+uG9Opa7fApA-GH9pW4v0En5j6QSPf1yZw@mail.gmail.com>
Message-ID: <CAK8P3a38TyiHXBgB0DQka=0iASuyJO_zMrczXqYBiJj6LEnNWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 7, 2017 at 7:45 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> at the bottom (with a comment) would be cleaner, and
> we wouldn't need to modify all the existing lines.
> AFAIK about Makefiles, that should work?

Ah, yes. That's much better.

      Arnd
