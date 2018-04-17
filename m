From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 17 Apr 2018 10:08:04 -0600
Subject: [PATCH v2 0/3] coresight: Refresh documenation 
Message-ID: <1523981287-15370-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the perf tools CoreSight support is upstream this set adds
documentation to go with it and move things around so that topics 
are located together.

--------
Changes for V2:
* Addressed grammatical problems highlighted by Randy

Mathieu Poirier (3):
  coresight: Remove obsolete reference to "owner" in CoreSight
    descriptor
  coresight: Add section for integration with the perf tools
  coresight: Grouping all perf tools oriented section together

 Documentation/trace/coresight.txt | 103 +++++++++++++++++++++++++++-----------
 1 file changed, 75 insertions(+), 28 deletions(-)

-- 
2.7.4
