From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 13:21:30 -0500
Subject: [PATCH 2/5] ARM: davinci: da8xx: add usb phy clocks
In-Reply-To: <56E9A01B.3010503@cogentembedded.com>
References: <1458081473-8223-1-git-send-email-david@lechnology.com>
 <1458081473-8223-2-git-send-email-david@lechnology.com>
 <56E95128.5000607@cogentembedded.com> <56E99ECA.90400@lechnology.com>
 <56E9A01B.3010503@cogentembedded.com>
Message-ID: <56E9A42A.6090506@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2016 01:04 PM, Sergei Shtylyov wrote:
>
>     No, I mean why is not this implemented as a part of clk_set_parent()?
>

There is not currently any framework for mux clocks in the davinci 
clocks. I am hoping to eventually get the davinci clocks moved to the 
common clock framework, so this was just a hack to get things working 
with what was already existing. I did not want to spend the time fixing 
it twice.
