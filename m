From: avictor.za@gmail.com (Andrew Victor)
Date: Wed, 2 Nov 2011 07:43:28 +0200
Subject: AT91 reboot code
In-Reply-To: <20111101144058.GP19187@n2100.arm.linux.org.uk>
References: <20111101144058.GP19187@n2100.arm.linux.org.uk>
Message-ID: <CAFumwP2m7=QsMTGAafPJs2ekm0R5FqCg8QxbOESBCq5r1PQkrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Russell,

> Is there any reason this can't just be:
>
> void (*arch_reset)(char mode, const char *cmd);

I don't see any reason why not, except if arch_reset() can be called
early in the setup code (before the platform initialization).


Regards,
  Andrew Victor
