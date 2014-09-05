From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 4 Sep 2014 17:14:53 -0700
Subject: [PATCH] genirq: Introduce irq_read_line()
In-Reply-To: <1408479811-26088-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1408479811-26088-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <CAJAp7OgGPZZuCgC8iUiW2jrEVubK=KCATxd6eazdT1x1sSrffg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 1:23 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> Introduce the irq_read_line() function to allow device drivers to read
> the current logical state of an input when the hardware only exposes
> this through status bits in the interrupt controller.
>
> The new function is backed by a new callback function in the irq_chip -
> irq_read_line() - that can be implemented by irq_chips that owns such
> status bits.
>
> Based on rfc patch from April 2011 by Abhijeet.
>
> Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

ping?
