From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 23:11:41 +0200
Subject: [PATCH 01/26] ARM: nomadik: move mtu setup to clocksource init
In-Reply-To: <523CB938.8000104@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdZqm=3oed979Jyg7n+8KwW_-2AGv3OzJBTPN20ZH=Vc3Q@mail.gmail.com>
 <CACRpkdauZCi+BDGa9gAZq0eG1jzHBuym5RzzwfxxcCMCAFJZEg@mail.gmail.com>
 <523CB938.8000104@gmail.com>
Message-ID: <CACRpkdagqLKr6WqzHLCa9N27HMYcZkgW25UABLNPaT89fgXgkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 11:08 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> Ok, well I was looking at v3.12-rc1 and did not really follow other
> nomadik related threads. That time ux500 wasn't tangled up with
> clk-nomadik.

Well yeah, you're right. But Lee has a pending patch set that
makes the ux500 use this for its OF boot path...

Yours,
Linus Walleij
