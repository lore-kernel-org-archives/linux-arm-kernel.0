From: rpeterso@redhat.com (Bob Peterson)
Date: Tue, 2 Jan 2018 08:56:27 -0500 (EST)
Subject: [Cluster-devel] [PATCH 00/12] drop unneeded newline
In-Reply-To: <1878806802.2632123.1514901158666.JavaMail.zimbra@redhat.com>
References: <1514386305-7402-1-git-send-email-Julia.Lawall@lip6.fr>
 <1878806802.2632123.1514901158666.JavaMail.zimbra@redhat.com>
Message-ID: <1019862289.2632779.1514901387442.JavaMail.zimbra@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- Original Message -----
| ----- Original Message -----
| | Drop newline at the end of a message string when the printing function adds
| | a newline.
| 
| Hi Julia,
| 
| NACK.
| 
| As much as it's a pain when searching the source code for output strings,
| this patch set goes against the accepted Linux coding style document. See:
| 
| https://www.kernel.org/doc/html/v4.10/process/coding-style.html#breaking-long-lines-and-strings
| 
| Regards,
| 
| Bob Peterson
| 
| 
Hm. I guess I stand corrected. The document reads:

"However, never break user-visible strings such as printk messages, because that breaks the ability to grep for them."

Still, the GFS2 and DLM code has a plethora of broken-up printk messages,
and I don't like the thought of re-combining them all.

Regards,

Bob Peterson
