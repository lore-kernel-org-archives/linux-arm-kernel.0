From: markus@trippelsdorf.de (Markus Trippelsdorf)
Date: Thu, 11 Jul 2013 11:46:40 +0200
Subject: [PATCH] .gitignore: ignore *.lz4 files
In-Reply-To: <20130711043433.GA29245@hulk>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <1367829775-4434-2-git-send-email-kyungsik.lee@lge.com>
 <20130506095124.GA22041@pd.tnic>
 <CAMuHMdWH9w5fj6HRXi+9QcBJym4dukAFsPVGZVqSSk3yTZJUcA@mail.gmail.com>
 <20130710093642.GC14873@pd.tnic> <20130710182815.GA362@x4>
 <20130711043433.GA29245@hulk>
Message-ID: <20130711094640.GA358@x4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that lz4 kernel compression is available, add *.lz4 to .gitignore.

Signed-off-by: Markus Trippelsdorf <markus@trippelsdorf.de>
Acked-by: Kyungsik Lee <kyungsik.lee@lge.com>

diff --git a/.gitignore b/.gitignore
index 3b8b9b3..7e9932e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -29,6 +29,7 @@ modules.builtin
 *.bz2
 *.lzma
 *.xz
+*.lz4
 *.lzo
 *.patch
 *.gcno
-- 
Markus
