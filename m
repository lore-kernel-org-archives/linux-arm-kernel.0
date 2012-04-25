From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Apr 2012 12:43:57 +0200
Subject: [PATCH 7.1/15] ARM: ux500: Enable the SMSC9115 on Snowball via
 Device Tree
In-Reply-To: <4F96793C.9080709@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdZzAQNJ9ejKJJQJhEPjO9VO+fPHmPeCErg8XOj-dLc3gA@mail.gmail.com>
 <4F96793C.9080709@linaro.org>
Message-ID: <CACRpkdbm2XBskEOgFhkREAi5T0Vsu6PKAYoFNEjnJiA6kjgzug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 11:58 AM, Lee Jones <lee.jones@linaro.org> wrote:

> From: Lee Jones <lee.jones@linaro.org>
> Date: Tue, 24 Apr 2012 10:53:18 +0100
> Subject: [PATCH 07.1/15] ARM: ux500: Enable the SMSC9115 on Snowball via Device Tree
>
> Here we split the description of the external-bus at 50000000 over
> two description files. In the more generic db8500 description file
> we only specify the external-bus. Normally this would be used to
> communicate with a NOR-flash device. On the Snowball however, the
> SMSC9115 Ethernet chip occupies it. In the Snowball board specific
> description file is where we actually specify that it is in fact the
> Ethernet device which lives here.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied with some manual intervention, don't quite know
why we don't have identical merge bases but whatever,
check the end result.

(You can do that by going to the branch ux500-devicetree
in my linux-stericsson git.)

Linus Walleij
