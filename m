From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 26 Mar 2010 22:23:11 +0300
Subject: [PATCH v2 0/3] Support for Cavium Networks CNS3xxx machines
Message-ID: <20100326192311.GA8313@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here comes v2. Changes since v1:

- Addressed Russell's comments;
- CNS3420VB board support split into its own patch per Sergei's
  comment;
- This series no longer include AHCI and SDHCI patches. Because of
  dependencies on other trees they aren't yet suitable for inclusion,
  so no need to repost them again.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
