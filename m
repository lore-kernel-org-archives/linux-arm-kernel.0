From: chris.brand@broadcom.com (Chris Brand)
Date: Mon, 9 May 2016 15:31:31 -0700
Subject: [PATCH 0/6] Support BCM23550 SoC
In-Reply-To: <6872671.Czyv7J9iJZ@wuerfel>
References: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
 <6872671.Czyv7J9iJZ@wuerfel>
Message-ID: <CAMsMSK-MwY6HDmb45vj6g2BTM9yk7+g5oP0hEm9gk6Gi7f+XjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 5, 2016 at 2:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
[...]
> Looks really nice overall, I only found one tiny detail I commented on
> for patch 6.

Thanks!

> I'm glad to see work on the old chips resume, are you working on new
> code for it as well, or just upstreaming the patches that were already
> done in the past?


This is new work. It was actually a good testament to the value of
upstreaming that it was so easy to bring up a 4.6 kernel on this chip.

Chris
