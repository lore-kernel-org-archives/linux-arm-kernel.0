From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 Aug 2011 15:49:24 +0200
Subject: [RFC PATCH 0/2] WIP: generic OF pinmux binding
In-Reply-To: <1313581648-22303-1-git-send-email-jamie@jamieiles.com>
References: <1313581648-22303-1-git-send-email-jamie@jamieiles.com>
Message-ID: <CACRpkdYyu9-6MMpnF5g6WPb8oXk9fuJxxqv6yTzc7Y5FsgbAyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2011 at 1:47 PM, Jamie Iles <jamie@jamieiles.com> wrote:

> To avoid going too far in the wrong direction I thought I'd post what I
> have so far for a generic pinmux binding.

It looks like a large part of the binding is about pulling, biasing,
input props like schmitt-triggering and so on, so since I use the
concept of "pincontrol" for all those things in my devised subsystem
can we call them "pincontrol bindings" rather than pinmux,
because pinmux is really just one part of it?

Thanks,
Linus Walleij
