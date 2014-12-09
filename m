From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 9 Dec 2014 14:50:05 -0700
Subject: [PATCH 6/6] pci, acpi: Share ACPI PCI config space accessors.
In-Reply-To: <54854FB2.8080206@linaro.org>
References: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org>
 <3957412.IooRKpIXjW@wuerfel> <20141121180825.GD6578@google.com>
 <2178540.dTppAIY2rE@wuerfel> <54854FB2.8080206@linaro.org>
Message-ID: <CAErSpo6cUuEK41wD33Uyzb5Y5yFp+jKVVvWLrZ0dO1iuYv8GjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 8, 2014 at 12:13 AM, Tomasz Nowicki
<tomasz.nowicki@linaro.org> wrote:

> What would be next steps regarding this patch set? I am not sure we have
> reached a consensus on weak vs #ifdef choice.

I work through the list at
https://patchwork.ozlabs.org/project/linux-pci/list/ in FIFO order, so
you don't need to do anything else except poke me to move faster :)

The weak/ifdef question is relatively minor and easily changed, so I
wouldn't worry about it yet.

Bjorn
