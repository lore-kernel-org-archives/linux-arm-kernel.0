From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 09:05:27 +0100
Subject: [PATCH 01/10] gpio: tegra: add gpio wakeup source handling
In-Reply-To: <5136381B.6000300@wwwdotorg.org>
References: <1362397186-5444-1-git-send-email-josephl@nvidia.com>
 <5136381B.6000300@wwwdotorg.org>
Message-ID: <CACRpkdY=218ms+q1UnARjCWot-XcYs62XEc4bT2Czu8PGfmtAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 5, 2013 at 7:23 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 03/04/2013 04:39 AM, Joseph Lo wrote:
>> This patch add the gpio wakeup source handling for the Tegra platform. It
>> was be done by enabling the irq for the gpio in the gpio controller and
>> enabling the bank irq of the gpio in the Tegra legacy irq controller when
>> the system going to suspend.
>
> Grant, Linus, I assume there's a runtime dependency of the rest of this
> series on this first patch. Can I get an ack to take this patch through
> the Tegra tree? Thanks.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Sorry for taking what, 22 days to ACK this... :(

Yours,
Linus Walleij
