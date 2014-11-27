From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 27 Nov 2014 01:48:27 +0100
Subject: [PATCH 4/8] opp: Introduce APIs to remove OPPs
In-Reply-To: <CAKohpomz-kekRU7YD8_TYbeVRRs7WmrqLFT0yALxXwFGjwqNOQ@mail.gmail.com>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
 <11530150.5svHxl9OuM@vostro.rjw.lan>
 <CAKohpomz-kekRU7YD8_TYbeVRRs7WmrqLFT0yALxXwFGjwqNOQ@mail.gmail.com>
Message-ID: <13263114.169IokuYNX@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 27, 2014 05:56:21 AM Viresh Kumar wrote:
> On 27 November 2014 at 04:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > That should work if I'm not mistaken, but I'm wondering if we could
> > settle on using one RCU type for this (later, though).
> 
> We can convert all call sites to use SRCU then. Once we are sure about it.

Yes, later.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
