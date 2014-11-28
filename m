From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 28 Nov 2014 13:59:46 +0100
Subject: [PATCH 0/5] sun6i: Add A31s (pinctrl) support
In-Reply-To: <CACRpkdb3P+KM+ANqe6fKqJcRnBp6zvJhWUFZDap8qFDWdY1JNQ@mail.gmail.com>
References: <1416747283-13489-1-git-send-email-hdegoede@redhat.com>
 <CACRpkdb3P+KM+ANqe6fKqJcRnBp6zvJhWUFZDap8qFDWdY1JNQ@mail.gmail.com>
Message-ID: <547871C2.6050209@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/28/2014 01:01 PM, Linus Walleij wrote:
> On Sun, Nov 23, 2014 at 1:54 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>
>> I'm not sure if sunxi pinctrl patches go through Maxime's tree or Linus' tree,
>> so I'll leave figuring out who takes what patches to you two.
>
> The changes in drivers/pinctrl and arch/* are usually orthogonal
> (just Kconfig symbols and DTS changes, no cross calls or header
> files that break compilation etc) and then they can be
> applied orthogonally. I just put the pinctrl patch in my tree and
> the rest in the platform tree.

Ok, note in case it was not clear there will be a v2, so please do not merge v1.

Thanks,

Hans
