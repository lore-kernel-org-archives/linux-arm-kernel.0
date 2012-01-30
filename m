From: vipulkumar.samar@st.com (vipul kumar samar)
Date: Mon, 30 Jan 2012 16:43:16 +0530
Subject: How to restore frame buffer contents on hibernation restore?
Message-ID: <4F267B4C.9000809@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

How can i restore frame buffer contents in case of hibernation??

FB memory is allocated through fixup calls and that area is not 
accessible to kernel. In case of hibernation while preparing kernel 
snapshot, FB is not accessible to kernel. That means kernel is not 
responsible to save content of FB.

How to restore frame buffer contents after restore??

Regards
Vipul Kumar Samar
