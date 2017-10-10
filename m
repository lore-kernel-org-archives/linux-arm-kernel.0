From: mhocko@kernel.org (Michal Hocko)
Date: Tue, 10 Oct 2017 16:15:47 +0200
Subject: [PATCH v11 0/9] complete deferred page initialization
In-Reply-To: <20171009221931.1481-1-pasha.tatashin@oracle.com>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
Message-ID: <20171010141547.zpdptsccsblyw634@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Btw. thanks for your persistance and willingness to go over all the
suggestions which might not have been consistent btween different
versions. I believe this is a general improvement in the early
initialization code. We do not rely on an implicit zeroing which just
happens to work by a chance. The perfomance improvements are a bonus on
top.

Thanks, good work!
-- 
Michal Hocko
SUSE Labs
