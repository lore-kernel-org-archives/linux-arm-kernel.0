From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Jul 2011 12:43:24 -0700
Subject: [PATCH 1/2] ARM: tegra: remove copy-and-pasted i2c platform data
	in boards
In-Reply-To: <1310336374-31727-1-git-send-email-ccross@android.com>
References: <1310336374-31727-1-git-send-email-ccross@android.com>
Message-ID: <CAOesGMjzSJ5S8gzhqnnQyzVrV5QKjYXQDRz_Twnc+1M8Ja9V-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 3:19 PM, Colin Cross <ccross@android.com> wrote:
> Every board file includes the same platform data definition
> for the i2c-tegra driver's bus speed. ?Move the platform data
> into devices.c, and remove it from all the board files.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Olof Johansson <olof@lixom.net>


As mentioned, hopefully board-specific overrides can be done via
device tree as things go in.


-Olof
