From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Mon, 30 May 2016 20:29:17 +0800
Subject: [PATCH v3 3/9] DocBook/v4l: Add compressed video formats used on
 MT8173 codec driver
In-Reply-To: <1464611363-14936-3-git-send-email-tiffany.lin@mediatek.com>
References: <1464611363-14936-1-git-send-email-tiffany.lin@mediatek.com>
 <1464611363-14936-2-git-send-email-tiffany.lin@mediatek.com>
 <1464611363-14936-3-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <1464611363-14936-4-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add V4L2_PIX_FMT_MT21 documentation

Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
---
 Documentation/DocBook/media/v4l/pixfmt.xml |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/DocBook/media/v4l/pixfmt.xml b/Documentation/DocBook/media/v4l/pixfmt.xml
index 5a08aee..d40e0ce 100644
--- a/Documentation/DocBook/media/v4l/pixfmt.xml
+++ b/Documentation/DocBook/media/v4l/pixfmt.xml
@@ -1980,6 +1980,12 @@ array. Anything what's in between the UYVY lines is JPEG data and should be
 concatenated to form the JPEG stream. </para>
 </entry>
 	  </row>
+	  <row id="V4L2_PIX_FMT_MT21">
+	    <entry><constant>V4L2_PIX_FMT_MT21</constant></entry>
+	    <entry>'MT21'</entry>
+	    <entry>Compressed two-planar YVU420 format used by Mediatek MT8173
+	    codec driver.</entry>
+	  </row>
 	</tbody>
       </tgroup>
     </table>
-- 
1.7.9.5
