From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jan 2015 11:26:08 +0100
Subject: [PATCH v5 5/5] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <1421402411-3479-6-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1421402411-3479-6-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <2026679.CiQSN0uJXp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 January 2015 18:00:11 Chunyan Zhang wrote:
> Add a full sc9836-uart driver for SC9836 SoC which is based on the
> spreadtrum sharkl64 platform.
> This driver also support earlycon.
> This patch also replaced the spaces between the macros and their
> values with the tabs in serial_core.h
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
> Originally-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
> 

I see nothing wrong with the patch contents, but a few things regarding
the submission process:

- The 'Signed-off-by' lines are in the wrong order. As the person
  sending it, your S-o-b should be the last one in the list

- You have too many people on 'To'. Please send the patch only to
  the person you expect to apply it, and put the other people that
  may be interested on Cc. A lot of the people who got this mail
  are probably not interested and you can drop them completely.

- Now that everything is reviewed, split the series according to
  subsystem maintainers and send it separately: patches 1,2 and 5
  should go to GregKH as one series, the rest should go to
  'arm at kernel.org'.

- For some reason I did not get patch 4. Can you check if that
  made it to the mailing list?

Feel free to add my 'Acked-by: Arnd Bergmann <arnd@arndb.de>' to
the patches you send to Greg.

	Arnd
