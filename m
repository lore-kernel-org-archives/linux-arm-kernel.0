From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 20 Jul 2017 10:03:26 +0200
Subject: [PATCH v2] PM / suspend: Add suspend_target_state()
In-Reply-To: <2615c143-6cb2-1b89-d453-921306d665b6@gmail.com>
 <CAJZ5v0gJQHUMEXTbvb0q6rmW-1xuRWAwGMmo_CCE8mYj-xf5QA@mail.gmail.com>
 <20170717200628.7018-1-f.fainelli@gmail.com>
Message-ID: <20170720080326.GA13103@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2017-07-17 13:06:28, Florian Fainelli wrote:
> Have the core suspend/resume framework store the system-wide suspend
> state (suspend_state_t) we are about to enter, and expose it to drivers
> via suspend_target_state() in order to retrieve that. The state is
> assigned in suspend_devices_and_enter().
> 
> This is useful for platform specific drivers that may need to take a
> slightly different suspend/resume path based on the system's
> suspend/resume state being entered.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170720/676f552a/attachment.sig>
