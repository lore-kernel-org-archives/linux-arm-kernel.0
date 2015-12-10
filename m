From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 19:04:38 +0100
Subject: [PATCH v2 0/3] gpio support for Broadcom NSP
In-Reply-To: <CACRpkdbnj1NCtPkMsaCQPb5cKXqz7D3dqF7vNf08NoK1sY_B5Q@mail.gmail.com>
References: <1449248981-12102-1-git-send-email-yrdreddy@broadcom.com>
 <CACRpkdbnj1NCtPkMsaCQPb5cKXqz7D3dqF7vNf08NoK1sY_B5Q@mail.gmail.com>
Message-ID: <CACRpkdYcYaG3J13gomnCtPzXcqE9SbTP_jWmyTE4Bgx4piELeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 6:47 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Dec 4, 2015 at 6:09 PM, Yendapally Reddy Dhananjaya Reddy
> <yrdreddy@broadcom.com> wrote:
>
>> This is the second iteration in the series.
>>
>> Changes in v2:
>> Addressed the review comments on device tree bindings and
>> the device tree file.
>
> I've merged this on a special branch so I can also pull it into the GPIO
> tree for pending refactorings.

Now generated two patches on top of this: one to chane .dev to .parent
and one for dealing with gpiochip_get_data()/gpiochip_add_data() from
my recent refactoring patch set.

Yours,
Linus Walleij
