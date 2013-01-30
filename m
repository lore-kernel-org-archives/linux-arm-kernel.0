From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 30 Jan 2013 18:46:14 +0800
Subject: [PATCH] ARM:mach-msm: seting tail NUL after strncpy
In-Reply-To: <87pq0nni3v.fsf@nemi.mork.no>
References: <5108A913.6080304@asianux.com> <87pq0nni3v.fsf@nemi.mork.no>
Message-ID: <5108F9F6.4080906@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?01?30? 17:19, Bj?rn Mork ??:
> Maybe use strlcpy() instead?

  ok, I will send patch v2.

  it will be "strlcpy(temp, clock->dbg_name, ARRAY_SIZE(temp));"


  thanks.

-- 
Chen Gang

Asianux Corporation
