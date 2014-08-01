From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 1 Aug 2014 16:02:25 +0300
Subject: [PATCH 5/6] ARM: DTS: da850-evm: Add node for tlv320aic3106 codec
In-Reply-To: <53DB8CEA.9010902@cogentembedded.com>
References: <1406801934-23334-1-git-send-email-peter.ujfalusi@ti.com>
 <1406801934-23334-6-git-send-email-peter.ujfalusi@ti.com>
 <53DA519A.4090905@cogentembedded.com> <53DB240F.2030908@ti.com>
 <53DB8CEA.9010902@cogentembedded.com>
Message-ID: <53DB8FE1.5010207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2014 03:49 PM, Sergei Shtylyov wrote:
>    I do. We should follow the standard consistently. Why not call the node
> "sound-codec"?

Well, there is _zero_ cases when the audio codec node is named as
"sound-codec" in linux-next but we have wmXXXX, tlvXXXX, twlXXXX, maxXXXX etc.
Yeah, there are few DTS files which have codec as node name.
So, no, I'm not going to change the node name from tlv320aic3106.

-- 
P?ter
