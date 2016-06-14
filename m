From: olof@lixom.net (Olof Johansson)
Date: Tue, 14 Jun 2016 10:32:42 -0700
Subject: [GIT PULL] Amlogic DT changes for v4.8
In-Reply-To: <7h60tcdbox.fsf@baylibre.com>
References: <7h60tcdbox.fsf@baylibre.com>
Message-ID: <20160614173242.GH9200@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 02:24:30PM -0700, Kevin Hilman wrote:
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt
> 
> for you to fetch changes up to bf205ad75a17a878aa0c350d1ce376adaeb69fea:
> 
>   ARM: dts: amlogic: Enable Reset Controller on Meson8b platforms (2016-06-01 10:57:42 -0700)
> 
> ----------------------------------------------------------------
> Amlogic DT changes for v4.8
> - add pinctrl driver and pins for several devices
> - add reset driver

Hi,

We have traditionally kept 32- and 64-bit DT updates separate. Would you mind
respinning with the 32-bit change in a separate branch or as a standalone
patch?



-Olof
