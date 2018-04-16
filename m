From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 16 Apr 2018 13:35:24 -0600
Subject: [PATCH 0/3] coresight: Refresh documenation 
Message-ID: <1523907327-20979-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the perf tools CoreSight support is upstream this set adds
documentation to go with it and move things around so that topics 
are located together. 

Mathieu Poirier (3):
  coresight: Remove obsolete reference to "owner" in CoreSight
    descriptor
  coresight: Add section for integration with the perf tools
  coresight: Grouping all perf tools oriented section together

 Documentation/trace/coresight.txt | 101 ++++++++++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 27 deletions(-)

-- 
2.7.4
