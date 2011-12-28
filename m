From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Dec 2011 21:16:14 -0800
Subject: [PATCH 2/2] Input: tegra-kbc - add default chromeos map
In-Reply-To: <1325049024-7588-3-git-send-email-olof@lixom.net>
References: <1325049024-7588-1-git-send-email-olof@lixom.net>
 <1325049024-7588-3-git-send-email-olof@lixom.net>
Message-ID: <CAOesGMjhL3z2grN1aK12O=sq0tdKhj-XrWixv4n-wGGVrJL7ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2011 at 9:10 PM, Olof Johansson <olof@lixom.net> wrote:
> This adds a simple way to specify the ChromeOS-specific keyboard map
> instead of the "standard" map that is used on other Tegra devices such
> as Harmony-with-keyboard and Seaboard.
>
> I expect the number of different keyboard layouts to be quite limited,
> and not many should be added over time. So instead of encoding the layout
> in the device tree, with all the can of worms that entails w.r.t. agreeing
> on a suitable binding, just add a property to specify that this is the
> map to be used, and include it in the driver.
>
> If, over time, the number of mappings increase, the binding can be
> updated to include a custom map as a new property, without having to
> worry about backwards compatibility on existing devices.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>

Ack, hold off on this one -- it needs more initialization than what I did below.


-Olof
