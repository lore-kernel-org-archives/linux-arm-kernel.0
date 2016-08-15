From: ayaka@soulik.info (Randy Li)
Date: Tue, 16 Aug 2016 04:42:06 +0800
Subject: [PATCH] Try to support analog audio codec at firefly reload
Message-ID: <1471293727-26258-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello:
  This patch could enabled the es8328 codec at firefly reload board,
but it doesn't not really work. I disable the mute of channel 
Left mix and Right mix in alsamixer, I could hear the noise from
my headphone, but it never be a music. 
  I just send this patch here to see whether somebody could figure
out what is wrong, I am really not familiar with sound.

Randy Li (1):
  ARM: dts: rockchip: add analog audio support for firefly reload

 arch/arm/boot/dts/rk3288-firefly-reload.dts | 36 +++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 5 deletions(-)

-- 
2.7.4
