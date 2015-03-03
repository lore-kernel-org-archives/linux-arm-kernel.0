From: wangnan0@huawei.com (Wang Nan)
Date: Tue, 3 Mar 2015 13:09:02 +0800
Subject: [PATCH 0/3] early kprobes: Fix bug in unregistering early kprobe
 before kprobe is ready.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425359345-38714-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In my RFC patch series of early kprobes, unregistering early kprobe on
ftrace triggers ftrace_bug(). This series of patch provides a fix.
I'll merge them in next version of early kprobe patch series.

-- 
1.8.4
