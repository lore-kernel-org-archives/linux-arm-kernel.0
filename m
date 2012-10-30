From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Oct 2012 23:27:18 +0100
Subject: [PATCH] mvebu-gpio: Disable blinking when enabling a GPIO for
 output
In-Reply-To: <CACRpkdY-aAxJpA7qvKWzxLRC-5_eC6cOZr7wsTLsFprOSbJ6CA@mail.gmail.com>
References: <1351427004-32110-1-git-send-email-jm@lentin.co.uk>
 <CACRpkdY-aAxJpA7qvKWzxLRC-5_eC6cOZr7wsTLsFprOSbJ6CA@mail.gmail.com>
Message-ID: <20121030232718.556604f8@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Linus Walleij,

On Tue, 30 Oct 2012 23:16:26 +0100, Linus Walleij wrote:

> Can I have some ACK on this thing from Andrew or Thomas say...

I just gave a formal ACK to the patch.

> Also is this a thing for the stable kernel -rc series or next
> merge window? I couldn't quite figure out if it was a regression.

I don't think it is really necessary to have it in the 3.7-rc series.
The driver has been introduced in 3.7, but technically speaking,
nothing is using it yet. Users will only be introduced in 3.8.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
